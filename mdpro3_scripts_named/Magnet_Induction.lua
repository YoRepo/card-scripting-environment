--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 磁力诱导  (ID: 54734082)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 473
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有原本等级是4星以下的「磁石战士」怪兽存在的场合才能发动。同名卡不在自己场上存在的1只4星以下的「磁石战士」怪兽从卡组特殊召唤。这张卡的发动后，直到回合结束时自己场上的「磁石战士」怪兽不会
-- 被战斗以及对方的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--マグネット・インダクション
function c54734082.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,54734082+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c54734082.spcon)
	e1:SetTarget(c54734082.sptg)
	e1:SetOperation(c54734082.spop)
	c:RegisterEffect(e1)
end
function c54734082.cpfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2066) and c:GetOriginalLevel()<=4
end
function c54734082.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c54734082.cpfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c54734082.cfilter2(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c54734082.spfilter(c,e,tp)
	return c:IsSetCard(0x2066) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not Duel.IsExistingMatchingCard(c54734082.cfilter2,tp,LOCATION_ONFIELD,0,1,nil,c:GetCode())
end
function c54734082.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c54734082.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c54734082.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		--change damage
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetTarget(c54734082.indtg)
		e1:SetValue(1)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e2:SetValue(aux.indoval)
		Duel.RegisterEffect(e2,tp)
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c54734082.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c54734082.indtg(e,c)
	return c:IsType(TYPE_MONSTER) and (c:IsSetCard(0x2066) or c:IsSetCard(0xe9)) and c:IsFaceup()
end
