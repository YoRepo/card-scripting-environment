--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 强袭冲击  (ID: 30643162)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上存在的怪兽攻击宣言时才能发动。那只怪兽的攻击力直到结束阶段时上升700。那只怪兽攻击守备表示怪兽的场合，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--ストライク・ショット
function c30643162.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c30643162.target)
	e1:SetOperation(c30643162.activate)
	c:RegisterEffect(e1)
end
function c30643162.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsControler(tp) and tg:IsOnField() end
	Duel.SetTargetCard(tg)
end
function c30643162.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(700)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_PIERCE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
