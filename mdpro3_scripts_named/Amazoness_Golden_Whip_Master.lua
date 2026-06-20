--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 亚马逊金鞭使  (ID: 97692972)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Warrior
-- Level 5
-- Pendulum Scales: L1 / R1
-- ATK 2000 | DEF 1200
-- Setcode: 4
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- 这个卡名的②的灵摆效果1回合只能使用1次。
-- ①：自己场上的「亚马逊」怪兽的攻击力上升自身的等级×100。
-- ②：自己的「亚马逊」怪兽进行战斗的攻击宣言时，以场上1张魔法·陷阱卡为对象才能发动。那张卡破坏。
-- 【怪兽效果】
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：怪兽区域的这张卡被战斗·效果破坏的场合才能发动。这张卡在自己的灵摆区域放置。
-- ②：这张卡在墓地存在的状态，自己场上有「亚马逊」怪兽特殊召唤的场合才能发动。这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの金鞭使い
function c97692972.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x4))
	e1:SetValue(c97692972.atkval)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,97692972)
	e2:SetCondition(c97692972.descon)
	e2:SetTarget(c97692972.destg)
	e2:SetOperation(c97692972.desop)
	c:RegisterEffect(e2)
	--pendulum
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,97692973)
	e3:SetCondition(c97692972.pencon)
	e3:SetTarget(c97692972.pentg)
	e3:SetOperation(c97692972.penop)
	c:RegisterEffect(e3)
	--pendulem
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_LEAVE_GRAVE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,97692974)
	e4:SetCondition(c97692972.pencon2)
	e4:SetTarget(c97692972.pentg2)
	e4:SetOperation(c97692972.penop)
	c:RegisterEffect(e4)
end
function c97692972.atkval(e,c)
	return c:GetLevel()*100
end
function c97692972.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetBattleMonster(tp)
	return tc and tc:IsSetCard(0x4) and tc:IsFaceup()
end
function c97692972.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c97692972.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c97692972.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c97692972.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c97692972.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c97692972.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c97692972.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c97692972.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c97692972.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_PZONE,0) and not Duel.CheckLocation(tp,LOCATION_PZONE,1) then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
function c97692972.penfilter(c,tp)
	return c:IsSetCard(0x4) and c:IsControler(tp)
end
function c97692972.pencon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c97692972.penfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function c97692972.pentg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
