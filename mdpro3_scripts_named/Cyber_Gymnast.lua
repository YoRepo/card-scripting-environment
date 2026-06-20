--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 电子化体操员  (ID: 76763417)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 800 | DEF 1800
-- Setcode: 147
--
-- Effect Text:
-- ①：1回合1次，丢弃1张手卡，以对方场上1只表侧攻击表示怪兽为对象才能发动。那只对方的表侧攻击表示怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--サイバー・ジムナティクス
function c76763417.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76763417,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c76763417.descost)
	e1:SetTarget(c76763417.destg)
	e1:SetOperation(c76763417.desop)
	c:RegisterEffect(e1)
end
function c76763417.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c76763417.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
function c76763417.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c76763417.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c76763417.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c76763417.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c76763417.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsPosition(POS_FACEUP_ATTACK) and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
