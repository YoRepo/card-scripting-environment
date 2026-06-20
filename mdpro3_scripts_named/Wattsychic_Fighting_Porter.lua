--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 电气念力战斗传送士  (ID: 51303014)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 14
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从手卡把最多2只3星以下的光属性怪兽特殊召唤。这个效果把原本种族相同的2只怪兽特殊召唤的场合，这个回合，那些怪兽可以直接攻击。这个效果把原本等级相同的2只怪兽特殊召唤的场合，这个回合，那些怪兽不会
-- 被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--エレキック・ファイティング・ポーター
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLevelBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=math.min(2,(Duel.GetLocationCount(tp,LOCATION_MZONE)))
	if ct<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_HAND,0,1,ct,nil,e,tp)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		if g:GetClassCount(Card.GetOriginalRace)==1 and g:GetCount()>1 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DIRECT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
		if g:GetClassCount(Card.GetOriginalLevel)==1 and g:GetCount()>1 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e2:SetValue(1)
			tc:RegisterEffect(e2)
		end
	end
	Duel.SpecialSummonComplete()
end
