--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 蜘蛛网  (ID: 69408987)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 怪兽攻击宣言的场合，那只怪兽在伤害步骤结束时变成守备表示，直到从那只怪兽的控制者来看的下次的自己回合的结束阶段时不能把表示形式改变。
--[[ __CARD_HEADER_END__ ]]

--スパイダー・ウェブ
function c69408987.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to defense
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c69408987.poscon)
	e2:SetOperation(c69408987.posop)
	c:RegisterEffect(e2)
end
function c69408987.poscon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsPosition(POS_FACEUP_ATTACK) and a:IsRelateToBattle()
end
function c69408987.posop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.ChangePosition(a,POS_FACEUP_DEFENSE)~=0 then
		e:GetHandler():CreateRelation(a,RESET_EVENT+RESETS_STANDARD)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,3)
		e1:SetCondition(c69408987.poscon2)
		a:RegisterEffect(e1)
	end
end
function c69408987.poscon2(e)
	return e:GetOwner():IsRelateToCard(e:GetHandler())
end
