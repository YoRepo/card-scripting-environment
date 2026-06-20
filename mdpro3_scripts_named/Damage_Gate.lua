--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 伤害之门  (ID: 87106146)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己受到战斗伤害时才能发动。把持有那个时候受到的伤害数值以下的攻击力的1只怪兽从自己墓地往场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ダメージ・ゲート
function c87106146.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c87106146.condition)
	e1:SetTarget(c87106146.target)
	e1:SetOperation(c87106146.activate)
	c:RegisterEffect(e1)
end
function c87106146.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c87106146.filter(c,e,tp,dam)
	return c:IsAttackBelow(dam) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c87106146.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c87106146.filter(chkc,e,tp,ev) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c87106146.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,ev) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c87106146.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,ev)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c87106146.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
