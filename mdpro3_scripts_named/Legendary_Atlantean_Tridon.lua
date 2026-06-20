--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 真海皇 特里冬  (ID: 28754338)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 3
-- ATK 1600 | DEF 800
-- Setcode: 119
--
-- Effect Text:
-- 把这张卡和自己场上1只海龙族怪兽解放才能发动。从手卡·卡组把1只「海皇龙 波塞德拉」特殊召唤。那之后，对方场上的全部怪兽的攻击力下降300。
--[[ __CARD_HEADER_END__ ]]

--真海皇 トライドン
function c28754338.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28754338,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c28754338.spcost)
	e1:SetTarget(c28754338.sptg)
	e1:SetOperation(c28754338.spop)
	c:RegisterEffect(e1)
end
function c28754338.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() and Duel.CheckReleaseGroup(tp,Card.IsRace,1,c,RACE_SEASERPENT) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,c,RACE_SEASERPENT)
	rg:AddCard(c)
	Duel.Release(rg,REASON_COST)
end
function c28754338.filter(c,e,tp)
	return c:IsCode(47826112) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c28754338.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c28754338.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c28754338.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c28754338.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.BreakEffect()
		local tg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local tc=tg:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-300)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			tc=tg:GetNext()
		end
	end
end
