--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 弯月罩  (ID: 83880087)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：怪兽的攻击无效时，可以从以下效果选择1个发动。
-- ●变成这个回合的结束阶段。
-- ●以自己场上1只「希望皇 霍普」超量怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时变成原本攻击力的2倍。
-- ②：自己场上的「希望皇 霍普」超量怪兽把超量素材1个取除来让效果发动的场合，可以作为取除的超量素材的代替而把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--ムーンバリア
function c83880087.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_DISABLED)
	e1:SetTarget(c83880087.target)
	e1:SetOperation(c83880087.operation)
	c:RegisterEffect(e1)
	--remove overlay replace
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83880087,2))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c83880087.rcon)
	e2:SetOperation(c83880087.rop)
	c:RegisterEffect(e2)
end
function c83880087.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x107f)
end
function c83880087.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c83880087.filter(chkc) end
	if chk==0 then return true end
	local op=0
	if Duel.IsExistingTarget(c83880087.filter,tp,LOCATION_MZONE,0,1,nil) then
		op=Duel.SelectOption(tp,aux.Stringid(83880087,0),aux.Stringid(83880087,1))
	else
		op=Duel.SelectOption(tp,aux.Stringid(83880087,0))
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(0)
		e:SetProperty(0)
	else
		e:SetCategory(CATEGORY_ATKCHANGE)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,c83880087.filter,tp,LOCATION_MZONE,0,1,1,nil)
	end
end
function c83880087.operation(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==0 then
		c83880087.endop(e,tp,eg,ep,ev,re,r,rp)
	elseif op==1 then
		c83880087.atkop(e,tp,eg,ep,ev,re,r,rp)
	end
end
function c83880087.endop(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	Duel.SkipPhase(turnp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(turnp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	Duel.SkipPhase(turnp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,turnp)
end
function c83880087.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetBaseAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c83880087.rcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_COST)~=0 and re:IsActivated()
		and re:IsActiveType(TYPE_XYZ) and re:GetHandler():IsSetCard(0x107f)
		and e:GetHandler():IsAbleToRemoveAsCost()
		and ep==e:GetOwnerPlayer() and ev==1
end
function c83880087.rop(e,tp,eg,ep,ev,re,r,rp)
	return Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
