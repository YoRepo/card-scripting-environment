--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 娱乐伙伴 飞毯鼯鼠  (ID: 20281581)
-- Type: Monster / Effect / Toon / Pendulum
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- Pendulum Scales: L7 / R7
-- ATK 1000 | DEF 100
-- Setcode: 159
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- ①：另一边的自己的灵摆区域没有卡存在的场合这张卡破坏。
-- ②：只要这张卡在灵摆区域存在，自己受到的战斗伤害变成一半。
-- 【怪兽效果】
-- ①：这张卡反转的场合，以场上盖放的1张卡为对象才能发动。那张卡破坏。
-- ②：这张卡特殊召唤成功的场合才能发动。这张卡变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--EMモモンカーペット
function c20281581.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--selfdes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c20281581.descon)
	c:RegisterEffect(e1)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(HALF_DAMAGE)
	c:RegisterEffect(e2)
	--flip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20281581,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetTarget(c20281581.target)
	e3:SetOperation(c20281581.operation)
	c:RegisterEffect(e3)
	--sp set
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20281581,2))
	e4:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetTarget(c20281581.postg)
	e4:SetOperation(c20281581.posop)
	c:RegisterEffect(e4)
end
function c20281581.descon(e)
	return not Duel.IsExistingMatchingCard(nil,e:GetHandlerPlayer(),LOCATION_PZONE,0,1,e:GetHandler())
end
function c20281581.filter(c)
	return c:IsFacedown()
end
function c20281581.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c20281581.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20281581.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c20281581.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c20281581.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c20281581.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c20281581.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
