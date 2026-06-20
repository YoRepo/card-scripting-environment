--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 球体时限炸弹  (ID: 26302522)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1400 | DEF 1400
--
-- Effect Text:
-- ①：里侧守备表示的这张卡被对方怪兽攻击的伤害计算前发动。这张卡当作装备卡使用给那只攻击怪兽装备。
-- ②：用这张卡的效果把这张卡装备的下次的对方准备阶段发动。装备怪兽破坏，给与对方那个攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--スフィア・ボム 球体時限爆弾
function c26302522.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26302522,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetCondition(c26302522.eqcon)
	e1:SetOperation(c26302522.eqop)
	c:RegisterEffect(e1)
end
function c26302522.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() and e:GetHandler():GetBattlePosition()==POS_FACEDOWN_DEFENSE
end
function c26302522.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if not tc:IsRelateToBattle() or not c:IsRelateToBattle() then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() then
		Duel.Destroy(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c26302522.eqlimit)
	c:RegisterEffect(e1)
	--destroy&damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26302522,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c26302522.descon)
	e2:SetTarget(c26302522.destg)
	e2:SetOperation(c26302522.desop)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_OPPO_TURN+RESET_PHASE+PHASE_STANDBY)
	c:RegisterEffect(e2)
end
function c26302522.eqlimit(e,c)
	return e:GetOwner()==c
end
function c26302522.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c26302522.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=e:GetHandler():GetEquipTarget()
	ec:CreateEffectRelation(e)
	e:SetLabelObject(ec)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ec,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ec:GetAttack())
end
function c26302522.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ec=e:GetLabelObject()
	if ec:IsRelateToEffect(e) and ec:IsFaceup() then
		local atk=ec:GetAttack()
		if Duel.Destroy(ec,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		else Duel.Destroy(c,REASON_EFFECT) end
	end
end
