--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 星际仙踪-尾声  (ID: 12385638)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 210
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，自己的「星际仙踪」怪兽战斗破坏的怪兽不送去墓地回到持有者卡组。
-- ②：把墓地的这张卡除外才能发动。这个回合，自己的「星际仙踪」怪兽的战斗让自己受到战斗伤害的场合只有1次，作为代替让自己基本分回复那个数值。
--[[ __CARD_HEADER_END__ ]]

--Kozmo－エピローグ
function c12385638.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c12385638.tdtg)
	e2:SetValue(LOCATION_DECKSHF)
	c:RegisterEffect(e2)
	--damage conversion
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(aux.bfgcost)
	e3:SetOperation(c12385638.operation)
	c:RegisterEffect(e3)
end
function c12385638.tdtg(e,c)
	return c:IsSetCard(0xd2)
end
function c12385638.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_REVERSE_DAMAGE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c12385638.valcon)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c12385638.valcon(e,re,r,rp,rc)
	if bit.band(r,REASON_BATTLE)~=0 then
		local tp=e:GetHandlerPlayer()
		local bc=rc:GetBattleTarget()
		if bc and bc:IsSetCard(0xd2) and bc:IsControler(tp)
			and Duel.GetFlagEffect(tp,12385638)==0 then
			Duel.RegisterFlagEffect(tp,12385638,RESET_PHASE+PHASE_END,0,1)
			return true
		end
	end
	return false
end
