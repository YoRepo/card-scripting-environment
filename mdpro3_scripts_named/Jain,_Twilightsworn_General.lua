--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 暮光道将军 简  (ID: 84673417)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1200
-- Setcode: 56
--
-- Effect Text:
-- ①：1回合1次，从自己的手卡·墓地把1只「光道」怪兽除外，以场上1只表侧表示怪兽为对象才能发动。那只怪兽的攻击力·守备力直到回合结束时下降除外的怪兽的等级×300。
-- ②：1回合1次，这张卡以外的自己的「光道」怪兽的效果发动的场合发动。从自己卡组上面把2张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--トワイライトロード・ジェネラル ジェイン
function c84673417.initial_effect(c)
	--reduce atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84673417,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCost(c84673417.atkcost)
	e1:SetTarget(c84673417.atktg)
	e1:SetOperation(c84673417.atkop)
	c:RegisterEffect(e1)
	--mill
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84673417,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c84673417.ddcon)
	e2:SetTarget(c84673417.ddtg)
	e2:SetOperation(c84673417.ddop)
	c:RegisterEffect(e2)
end
function c84673417.atkcfilter(c)
	return c:IsSetCard(0x38) and c:IsLevelAbove(1) and c:IsAbleToRemoveAsCost()
end
function c84673417.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84673417.atkcfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c84673417.atkcfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetLevel())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c84673417.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c84673417.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local lv=e:GetLabel()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-lv*300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
function c84673417.ddcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and rc~=c
		and rc:IsSetCard(0x38) and rc:IsControler(tp)
end
function c84673417.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,2)
end
function c84673417.ddop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,2,REASON_EFFECT)
end
