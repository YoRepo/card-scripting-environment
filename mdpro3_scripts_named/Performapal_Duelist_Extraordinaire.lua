--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 娱乐伙伴 绝代决斗者  (ID: 92644052)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- Pendulum Scales: L8 / R8
-- ATK 1800 | DEF 400
-- Setcode: 159
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：1回合1次，怪兽之间进行战斗的伤害步骤开始时才能发动。这张卡回到持有者手卡，从卡组把1张魔法卡除外。自己怪兽不会被那次战斗破坏，那次战斗发生的对自己的战斗伤害变成一半。
-- 【怪兽效果】
-- ①：这张卡给与对方战斗伤害时才能发动。从卡组把1只「霸王眷龙」怪兽或者「霸王门」怪兽或者1张「霸王龙之魂」加入手卡。
-- ②：自己·对方的准备阶段发动。双方各自可以从自身卡组把1张魔法卡除外。
-- ③：1回合1次，自己或者对方的怪兽的攻击宣言时发动。被攻击的玩家可以让以下效果适用。
-- ●选除外的1张自身的魔法卡加入手卡。那之后，那张卡丢弃，那次攻击无效。
--[[ __CARD_HEADER_END__ ]]

--EM稀代の決闘者
local s,id,o=GetID()
function s.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(s.atkcon1)
	e1:SetTarget(s.atktg1)
	e1:SetOperation(s.atkop1)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(s.thcon)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(s.rmop)
	c:RegisterEffect(e3)
	--remove
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,3))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_HANDES)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(s.atktg2)
	e4:SetOperation(s.atkop2)
	c:RegisterEffect(e4)
end
function s.atkcon1(e,tp,eg,ep,ev,re,r,rp)
	local a,d=Duel.GetBattleMonster(tp)
	return a and d
end
function s.rmfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToRemove()
end
function s.atktg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand()
		and Duel.IsExistingMatchingCard(s.rmfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function s.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SendtoHand(c,nil,REASON_EFFECT)>0 and c:IsLocation(LOCATION_HAND) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,s.rmfilter,tp,LOCATION_DECK,0,1,1,nil)
		if #g>0 then
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		end
	end
	local tc=Duel.GetBattleMonster(tp)
	if tc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(HALF_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function s.thfilter(c)
	return c:IsAbleToHand() and (c:IsSetCard(0x10f8,0x20f8) and c:IsType(TYPE_MONSTER) or c:IsCode(92428405))
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetTurnPlayer()
	for i=1,2 do
		local g=Duel.GetMatchingGroup(s.rmfilter,p,LOCATION_DECK,0,nil)
		if #g>0 and Duel.SelectYesNo(p,aux.Stringid(id,4)) then
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_REMOVE)
			local tg=g:Select(p,1,1,nil)
			Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
		end
		p=1-p
	end
end
function s.atktg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-Duel.GetAttacker():GetControler())
end
function s.disfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsFaceup() and c:IsAbleToHand()
end
function s.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(s.disfilter,p,LOCATION_REMOVED,0,nil)
	if #g>0 and Duel.SelectYesNo(p,aux.Stringid(id,5)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_ATOHAND)
		local tc=g:Select(p,1,1,nil):GetFirst()
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
			Duel.ConfirmCards(1-p,tc)
			Duel.BreakEffect()
			if Duel.SendtoGrave(tc,REASON_EFFECT+REASON_DISCARD)>0 then
				Duel.NegateAttack()
			end
		end
	end
end
