--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 沼地的魔道王  (ID: 45223540)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 3
-- ATK 500 | DEF 1100
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡在手卡存在的场合才能发动。额外卡组1只融合怪兽给对方观看，那只怪兽有卡名记述的1只融合素材怪兽从卡组除外。那之后，这张卡特殊召唤。这个回合，把这个效果特殊召唤的这张卡作为融合素材的场合，可以
-- 当作这个效果除外的怪兽的同名卡使用。
--[[ __CARD_HEADER_END__ ]]

--沼地の魔道王
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
end
function s.ffilter(c,tp)
	return c:IsType(TYPE_FUSION) and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_DECK,0,1,nil,c)
end
function s.cfilter(c,tc)
	return aux.IsMaterialListCode(tc,c:GetCode()) and c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(s.ffilter,tp,LOCATION_EXTRA,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tc=Duel.SelectMatchingCard(tp,s.ffilter,tp,LOCATION_EXTRA,0,1,1,nil,tp):GetFirst()
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_DECK,0,1,1,nil,tc)
		local sc=sg:GetFirst()
		if sc and Duel.Remove(sc,POS_FACEUP,REASON_EFFECT)~=0 and c:IsRelateToChain()
			and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(id,1))
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_ADD_FUSION_CODE)
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetValue(sc:GetCode())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	end
end
