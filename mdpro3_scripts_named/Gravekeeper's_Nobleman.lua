--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 守墓的使徒  (ID: 85646474)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 46
--
-- Effect Text:
-- 这张卡被对方怪兽的攻击破坏送去墓地时，可以从卡组把「守墓的使徒」以外的1只名字带有「守墓」的怪兽里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--墓守の使徒
function c85646474.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85646474,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c85646474.condition)
	e1:SetTarget(c85646474.target)
	e1:SetOperation(c85646474.operation)
	c:RegisterEffect(e1)
end
function c85646474.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE)
		and c:IsPreviousControler(tp) and c==Duel.GetAttackTarget() and Duel.GetAttacker():IsControler(1-tp)
end
function c85646474.filter(c,e,tp)
	return c:IsSetCard(0x2e) and not c:IsCode(85646474) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c85646474.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c85646474.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c85646474.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c85646474.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
end
