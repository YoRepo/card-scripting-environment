--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 注射天使 莉莉  (ID: 79575620)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Spellcaster
-- Level 3
-- ATK 400 | DEF 1500
--
-- Effect Text:
-- ①：这张卡进行战斗的伤害计算时1次，支付2000基本分才能发动。这张卡的攻击力只在那次伤害计算时上升3000。
--[[ __CARD_HEADER_END__ ]]

--お注射天使リリー
function c79575620.initial_effect(c)
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79575620,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c79575620.con)
	e1:SetCost(c79575620.cost)
	e1:SetOperation(c79575620.op)
	c:RegisterEffect(e1)
end
function c79575620.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffect(79575620)==0 and (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c)
end
function c79575620.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
	e:GetHandler():RegisterFlagEffect(79575620,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c79575620.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(3000)
	c:RegisterEffect(e1)
end
