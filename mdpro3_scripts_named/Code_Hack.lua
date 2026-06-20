--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 代码入侵  (ID: 33750856)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上的电子界族连接怪兽不会被对方的效果破坏。
-- ②：1回合1次，自己和对方的怪兽之间进行战斗的战斗步骤才能发动。那只对方怪兽的攻击力直到回合结束时变成0，双方怪兽不会被那次战斗破坏，那次战斗发生的双方的战斗伤害变成0。
-- ③：自己的「码语者」怪兽攻击的伤害步骤对方把效果发动时，把墓地的这张卡除外才能发动。那个发动无效，那只攻击怪兽的攻击力上升700。
--[[ __CARD_HEADER_END__ ]]

--コード・ハック
local s,id,o=GetID()
function s.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indestructible
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.indestg)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--zero atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(s.zacon)
	e3:SetTarget(s.zatg)
	e3:SetOperation(s.zaop)
	c:RegisterEffect(e3)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCondition(s.negcon)
	e4:SetCost(aux.bfgcost)
	e4:SetTarget(s.negtg)
	e4:SetOperation(s.negop)
	c:RegisterEffect(e4)
end
function s.indestg(e,c)
	return c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_LINK)
end
function s.zacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget() and Duel.GetCurrentPhase()==PHASE_BATTLE_STEP
end
function s.zatg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetBattleMonster(1-tp)
	if chk==0 then return tc and aux.nzatk(tc) end
end
function s.zaop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetBattleMonster(1-tp)
	if tc and tc:IsRelateToBattle() and aux.nzatk(tc) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(0)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		e2:SetValue(1)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		tc:GetBattleTarget():RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD)
		e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e4:SetTargetRange(1,1)
		e4:SetValue(1)
		e4:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e4,tp)
	end
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and Duel.GetCurrentPhase()==PHASE_DAMAGE and Duel.GetTurnPlayer()==tp
		and Duel.GetAttacker():IsSetCard(0x101)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if Duel.NegateActivation(ev) and tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(700)
		tc:RegisterEffect(e1)
	end
end
