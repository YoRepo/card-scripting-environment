--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 瞬着炸弹  (ID: 53828396)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 3
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- 里侧守备表示的这张卡被对方怪兽攻击的场合，不进行伤害计算让这张卡变成攻击怪兽的装备卡。下次的对方回合的准备阶段时，那只装备怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--瞬着ボマー
function c53828396.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53828396,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetCondition(c53828396.eqcon)
	e1:SetOperation(c53828396.eqop)
	c:RegisterEffect(e1)
end
function c53828396.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() and e:GetHandler():GetBattlePosition()==POS_FACEDOWN_DEFENSE
end
function c53828396.eqop(e,tp,eg,ep,ev,re,r,rp)
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
	e1:SetValue(c53828396.eqlimit)
	c:RegisterEffect(e1)
	--destroy&damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(53828396,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c53828396.descon)
	e2:SetTarget(c53828396.destg)
	e2:SetOperation(c53828396.desop)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	c:RegisterEffect(e2)
end
function c53828396.eqlimit(e,c)
	return e:GetOwner()==c
end
function c53828396.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c53828396.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=e:GetHandler():GetEquipTarget()
	ec:CreateEffectRelation(e)
	e:SetLabelObject(ec)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ec,1,0,0)
end
function c53828396.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ec=e:GetLabelObject()
	if ec:IsRelateToEffect(e) and ec:IsFaceup() then
		if Duel.Destroy(ec,REASON_EFFECT)~=0 then
		else Duel.Destroy(c,REASON_EFFECT) end
	end
end
