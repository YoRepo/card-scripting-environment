--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 混沌No.39 希望皇 霍普雷·胜光  (ID: 87911394)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank 5
-- ATK 2800 | DEF 2500
-- Setcode: 276762696
--
-- Effect Text:
-- 5星怪兽×3
-- ①：这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
-- ②：这张卡有「希望皇 霍普」怪兽在作为超量素材的场合，得到以下效果。
-- ●这张卡向对方的表侧表示怪兽攻击宣言时，把这张卡1个超量素材取除才能发动。直到回合结束时，那只对方怪兽的效果无效化，这张卡的攻击力上升那只对方怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--CNo.39 希望皇ホープレイ・ヴィクトリー
function c87911394.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c87911394.aclimit)
	e1:SetCondition(c87911394.actcon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87911394,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c87911394.atkcon)
	e2:SetCost(c87911394.atkcost)
	e2:SetTarget(c87911394.atktg)
	e2:SetOperation(c87911394.atkop)
	c:RegisterEffect(e2)
end
aux.xyz_number[87911394]=39
function c87911394.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c87911394.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c87911394.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at and at:IsFaceup() and e:GetHandler():GetOverlayGroup():IsExists(Card.IsSetCard,1,nil,0x107f)
end
function c87911394.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c87911394.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(Duel.GetAttackTarget())
end
function c87911394.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		Duel.AdjustInstantly(tc)
		local atk=tc:GetAttack()
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(atk)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	end
end
