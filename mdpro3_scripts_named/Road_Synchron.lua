--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 王道同调士  (ID: 71971554)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1600 | DEF 800
-- Setcode: 4119
--
-- Effect Text:
-- ①：把这张卡作为「王道战士」以外的同调怪兽的素材的场合，当作这张卡的等级下降2星的等级使用。
-- ②：这张卡攻击的场合，那次伤害步骤结束时发动。这张卡的等级直到回合结束时上升1星。
--[[ __CARD_HEADER_END__ ]]

--ロード・シンクロン
function c71971554.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71971554,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c71971554.lvcon)
	e1:SetOperation(c71971554.lvop)
	c:RegisterEffect(e1)
	--lv up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_LEVEL)
	e2:SetValue(c71971554.lvval)
	c:RegisterEffect(e2)
end
function c71971554.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler() and e:GetHandler():IsRelateToBattle()
end
function c71971554.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c71971554.lvval(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsCode(2322421) then return lv
	else
		if lv<=2 then return 16 end
		return lv-2
	end
end
