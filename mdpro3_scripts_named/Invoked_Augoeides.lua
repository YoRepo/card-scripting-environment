--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 召唤兽 光体  (ID: 97300502)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level 8
-- ATK 2000 | DEF 2800
-- Setcode: 244
--
-- Effect Text:
-- 「召唤师 阿莱斯特」＋融合怪兽
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡特殊召唤成功的场合或者对方场上有怪兽特殊召唤的场合，以对方场上1只怪兽为对象才能发动。那只怪兽破坏。
-- ②：1回合1次，从自己墓地把1只融合怪兽除外才能发动。这张卡的攻击力直到对方回合结束时上升除外的怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--召喚獣アウゴエイデス
function c97300502.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,86120751,aux.FilterBoolFunction(Card.IsFusionType,TYPE_FUSION),1,true,true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(97300502,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,97300502)
	e1:SetTarget(c97300502.destg)
	e1:SetOperation(c97300502.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(97300502,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c97300502.descon)
	c:RegisterEffect(e2)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(97300502,2))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c97300502.atkcost)
	e4:SetOperation(c97300502.atkop)
	c:RegisterEffect(e4)
end
function c97300502.descon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(Card.IsControler,1,nil,1-tp)
end
function c97300502.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c97300502.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c97300502.atkfilter(c)
	return c:IsType(TYPE_FUSION) and c:IsAttackAbove(1) and c:IsAbleToRemoveAsCost()
end
function c97300502.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97300502.atkfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c97300502.atkfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local atk=g:GetFirst():GetAttack()
	e:SetLabel(atk)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c97300502.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=e:GetLabel()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		c:RegisterEffect(e1)
	end
end
