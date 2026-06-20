--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 音响战士 摇滚乐队  (ID: 24070330)
-- Type: Monster / Effect / Synchro / Pendulum
-- Attribute: WIND
-- Race: Machine
-- Level 7
-- Pendulum Scales: L10 / R10
-- ATK 2500 | DEF 1500
-- Setcode: 4198
--
-- Effect Text:
-- ←10 【灵摆】 10→
-- 这个卡名的①的灵摆效果1回合只能使用1次。
-- ①：自己·对方的准备阶段才能发动。从自己的额外卡组把1只表侧表示的灵摆怪兽加入手卡。
-- ②：对方怪兽的攻击宣言时才能发动。那只怪兽和这张卡破坏。
-- 【怪兽效果】
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：这张卡特殊召唤成功的场合才能发动。从自己的额外卡组把1只表侧表示的灵摆怪兽加入手卡。
-- ②：自己的场地区域有「音响放大器」存在的场合才能发动。选场上1张卡破坏。
-- ③：怪兽区域的这张卡被战斗·效果破坏的场合才能发动。这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--音響戦士ロックス
local s,id,o=GetID()
function c24070330.initial_effect(c)
	aux.AddCodeList(c,75304793)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--(pzone) to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24070330,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,24070330)
	e1:SetTarget(c24070330.thtg)
	e1:SetOperation(c24070330.thop)
	c:RegisterEffect(e1)
	--(pzone) destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24070330,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c24070330.pdcon)
	e2:SetTarget(c24070330.pdtg)
	e2:SetOperation(c24070330.pdop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24070330,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,24070330+o)
	e3:SetTarget(c24070330.thtg)
	e3:SetOperation(c24070330.thop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(24070330,3))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,24070330+o*2)
	e4:SetCondition(c24070330.descon)
	e4:SetTarget(c24070330.destg)
	e4:SetOperation(c24070330.desop)
	c:RegisterEffect(e4)
	--pendulum
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(24070330,4))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCondition(c24070330.pencon)
	e5:SetTarget(c24070330.pentg)
	e5:SetOperation(c24070330.penop)
	c:RegisterEffect(e5)
end
function c24070330.thfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c24070330.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c24070330.thfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c24070330.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c24070330.thfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c24070330.pdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp
end
function c24070330.pdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsRelateToBattle() end
	Duel.SetTargetCard(Duel.GetAttacker())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Group.FromCards(e:GetHandler(),Duel.GetAttacker()),2,0,0)
end
function c24070330.pdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local g=Group.FromCards(c,tc):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==2 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c24070330.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(75304793,tp,LOCATION_FZONE)
end
function c24070330.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c24070330.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c24070330.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c24070330.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c24070330.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
