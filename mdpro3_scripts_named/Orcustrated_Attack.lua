--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 自奏圣乐的起音  (ID: 29666221)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 283
--
-- Effect Text:
-- ①：自己或者对方的怪兽的攻击宣言时，把自己场上1只「自奏圣乐」怪兽或者「星遗物」怪兽解放，以对方场上1只怪兽为对象才能发动。那只怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--オルフェゴール・アタック
function c29666221.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCost(c29666221.cost)
	e1:SetTarget(c29666221.target)
	e1:SetOperation(c29666221.activate)
	c:RegisterEffect(e1)
end
function c29666221.cfilter(c)
	return c:IsSetCard(0xfe,0x11b)
end
function c29666221.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c29666221.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c29666221.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c29666221.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c29666221.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
