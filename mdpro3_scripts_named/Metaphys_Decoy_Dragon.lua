--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 玄化诱饵龙  (ID: 12196873)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Wyrm
-- Level 2
-- Pendulum Scales: L1 / R1
-- ATK 300 | DEF 200
-- Setcode: 261
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：自己怪兽被选择作为攻击对象时，从自己墓地的怪兽以及除外的自己怪兽之中以1只「玄化」怪兽为对象才能发动。这张卡除外，作为对象的怪兽攻击表示特殊召唤。
-- 【怪兽效果】
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：自己怪兽被选择作为攻击对象时，从自己墓地的怪兽以及除外的自己怪兽之中以1只「玄化」怪兽为对象才能发动。场上的这张卡除外，作为对象的怪兽攻击表示特殊召唤。
-- ②：这张卡被除外的下个回合的准备阶段才能发动。除外的这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--メタファイズ・デコイドラゴン
function c12196873.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12196873,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,12196873)
	e1:SetCondition(c12196873.spcon1)
	e1:SetTarget(c12196873.sptg1)
	e1:SetOperation(c12196873.spop1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,12196874)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(12196873,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1,12196875)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetCondition(c12196873.spcon2)
	e3:SetTarget(c12196873.sptg2)
	e3:SetOperation(c12196873.spop2)
	c:RegisterEffect(e3)
end
function c12196873.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget() and Duel.GetAttackTarget():IsControler(tp)
end
function c12196873.spfilter(c,e,tp)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsSetCard(0x105) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c12196873.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c12196873.spfilter(chkc,e,tp) end
	if chk==0 then return c:IsAbleToRemove()
		and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingTarget(c12196873.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c12196873.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c12196873.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and Duel.Remove(c,POS_FACEUP,REASON_EFFECT)~=0
		and c:IsLocation(LOCATION_REMOVED) and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
function c12196873.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetHandler():GetTurnID()+1
end
function c12196873.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c12196873.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
