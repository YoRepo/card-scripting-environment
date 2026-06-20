--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 娱乐伙伴 加号龟  (ID: 65195959)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 100 | DEF 1800
-- Setcode: 159
--
-- Effect Text:
-- ①：1回合1次，以场上最多2只表侧表示怪兽为对象才能发动。那些怪兽的等级上升1星。
--[[ __CARD_HEADER_END__ ]]

--EMプラスタートル
function c65195959.initial_effect(c)
	--lv
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65195959,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c65195959.target)
	e1:SetOperation(c65195959.operation)
	c:RegisterEffect(e1)
end
function c65195959.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c65195959.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c65195959.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c65195959.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c65195959.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,2,nil)
end
function c65195959.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
