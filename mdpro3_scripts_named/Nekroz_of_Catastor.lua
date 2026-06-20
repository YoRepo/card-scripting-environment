--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 灾亡虫之影灵衣  (ID: 52846880)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Dragon
-- Level 5
-- ATK 2200 | DEF 1200
-- Setcode: 180
--
-- Effect Text:
-- 「影灵衣」仪式魔法卡降临
-- 这张卡若非以只使用除「灾亡虫之影灵衣」以外的怪兽来作的仪式召唤则不能特殊召唤。这个卡名的①的效果1回合只能使用1次。
-- ①：把这张卡从手卡丢弃，以自己墓地1只「影灵衣」怪兽为对象才能发动。那只怪兽特殊召唤。
-- ②：自己的「影灵衣」怪兽和从额外卡组特殊召唤的怪兽进行战斗的伤害步骤开始时发动。那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--カタストルの影霊衣
function c52846880.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52846880,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,52846880)
	e2:SetCost(c52846880.spcost)
	e2:SetTarget(c52846880.sptg)
	e2:SetOperation(c52846880.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(52846880,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c52846880.condition)
	e3:SetTarget(c52846880.target)
	e3:SetOperation(c52846880.operation)
	c:RegisterEffect(e3)
end
function c52846880.mat_filter(c)
	return not c:IsCode(52846880)
end
function c52846880.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c52846880.spfilter(c,e,tp)
	return c:IsSetCard(0xb4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c52846880.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c52846880.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c52846880.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c52846880.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c52846880.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c52846880.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if tc:IsControler(1-tp) then tc,bc=bc,tc end
	if tc:IsSetCard(0xb4) and bc:IsSummonLocation(LOCATION_EXTRA) then
		e:SetLabelObject(bc)
		return true
	else return false end
end
function c52846880.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetLabelObject()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c52846880.operation(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
