--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 芳香法师-依兰  (ID: 22174866)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 3
-- ATK 1400 | DEF 1000
-- Setcode: 201
--
-- Effect Text:
-- ①：只要自己基本分比对方多并有这张卡在怪兽区域存在，对方场上的怪兽的攻击力·守备力下降500。
-- ②：1回合1次，自己基本分回复的场合，以对方场上1张魔法·陷阱卡为对象发动。那张卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--アロマージ－カナンガ
function c22174866.initial_effect(c)
	--atk & def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c22174866.adcon)
	e1:SetValue(-500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_RECOVER)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c22174866.thcon)
	e3:SetTarget(c22174866.thtg)
	e3:SetOperation(c22174866.thop)
	c:RegisterEffect(e3)
end
function c22174866.adcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)>Duel.GetLP(1-tp)
end
function c22174866.thcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c22174866.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c22174866.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c22174866.thfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c22174866.thfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c22174866.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
