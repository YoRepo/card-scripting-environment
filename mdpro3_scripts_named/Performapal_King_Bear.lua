--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 娱乐伙伴 国王熊精  (ID: 67808837)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 6
-- Pendulum Scales: L7 / R7
-- ATK 2200 | DEF 1000
-- Setcode: 159
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- ①：这张卡发动的回合的结束阶段才能发动。这张卡破坏，从自己的额外卡组的表侧表示的灵摆怪兽以及自己墓地的怪兽之中选1只7星以上的怪兽加入手卡。
-- 【怪兽效果】
-- ①：攻击表示的这张卡不会被魔法·陷阱卡的效果破坏。
-- ②：这张卡的攻击力在自己战斗阶段内上升自己场上的「娱乐伙伴」卡数量×100。
--[[ __CARD_HEADER_END__ ]]

--EMキングベアー
function c67808837.initial_effect(c)
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(1160)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c67808837.reg)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67808837,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c67808837.thcon)
	e2:SetTarget(c67808837.thtg)
	e2:SetOperation(c67808837.thop)
	c:RegisterEffect(e2)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c67808837.indescon)
	e3:SetValue(c67808837.indesval)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c67808837.atkcon)
	e4:SetValue(c67808837.atkval)
	c:RegisterEffect(e4)
end
function c67808837.reg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(67808837,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c67808837.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(67808837)~=0
end
function c67808837.thfilter(c)
	return c:IsLevelAbove(7) and (c:IsLocation(LOCATION_GRAVE) or (c:IsFaceup() and c:IsType(TYPE_PENDULUM))) and c:IsAbleToHand()
end
function c67808837.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable()
		and Duel.IsExistingMatchingCard(c67808837.thfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA+LOCATION_GRAVE)
end
function c67808837.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.Destroy(c,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c67808837.thfilter),tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c67808837.indescon(e)
	return e:GetHandler():IsAttackPos()
end
function c67808837.indesval(e,re,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c67808837.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	local tp=Duel.GetTurnPlayer()
	return tp==e:GetHandler():GetControler() and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c67808837.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c67808837.atkval(e,c)
	return Duel.GetMatchingGroupCount(c67808837.atkfilter,c:GetControler(),LOCATION_ONFIELD,0,nil)*100
end
