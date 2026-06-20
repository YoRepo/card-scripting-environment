--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 文具电子人005  (ID: 10117149)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level 5
-- Pendulum Scales: L10 / R10
-- ATK 500 | DEF 500
-- Setcode: 171
--
-- Effect Text:
-- ←10 【灵摆】 10→
-- ①：自己不是「文具电子人」怪兽不能灵摆召唤。这个效果不会被无效化。
-- 【怪兽效果】
-- 「文具电子人005」的③的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合，以场上1张魔法·陷阱卡为对象才能发动。那张卡破坏。
-- ②：这张卡的攻击力上升自己的额外卡组的表侧表示的「文具电子人」怪兽数量×500。
-- ③：这张卡在灵摆区域被破坏的场合，以自己墓地1只「文具电子人」怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ブンボーグ005
function c10117149.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c10117149.splimit)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetTarget(c10117149.destg)
	e3:SetOperation(c10117149.desop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--atk up
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(c10117149.atkval)
	c:RegisterEffect(e5)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetCountLimit(1,10117149)
	e6:SetCondition(c10117149.spcon)
	e6:SetTarget(c10117149.sptg)
	e6:SetOperation(c10117149.spop)
	c:RegisterEffect(e6)
end
function c10117149.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0xab) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c10117149.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c10117149.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c10117149.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10117149.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c10117149.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10117149.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c10117149.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xab)
end
function c10117149.atkval(e,c)
	return Duel.GetMatchingGroupCount(c10117149.cfilter,c:GetControler(),LOCATION_EXTRA,0,nil)*500
end
function c10117149.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_PZONE)
end
function c10117149.spfilter(c,e,tp)
	return c:IsSetCard(0xab) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10117149.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c10117149.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c10117149.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c10117149.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c10117149.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
