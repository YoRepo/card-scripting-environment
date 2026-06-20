--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 影依的炎核 虚梦狱  (ID: 92079625)
-- Type: Monster / Effect / Toon
-- Attribute: FIRE
-- Race: Fiend
-- Level 9
-- ATK 2900 | DEF 2900
-- Setcode: 157
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡反转的场合，以对方场上1只表侧表示怪兽为对象才能发动。属性和那只怪兽相同的1只「影依」怪兽从额外卡组送去墓地，作为对象的怪兽除外。
-- ②：这张卡被效果送去墓地的场合才能发动。把场上的怪兽的原本属性种类数量的卡从自己卡组上面送去墓地。
--[[ __CARD_HEADER_END__ ]]

--影依の炎核 ヴォイド
function c92079625.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92079625,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,92079625)
	e1:SetTarget(c92079625.target)
	e1:SetOperation(c92079625.operation)
	c:RegisterEffect(e1)
	--SendtoGrave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92079625,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,92079625)
	e2:SetCondition(c92079625.tgcon)
	e2:SetTarget(c92079625.tgtg)
	e2:SetOperation(c92079625.tgop)
	c:RegisterEffect(e2)
	c92079625.shadoll_flip_effect=e1
end
function c92079625.cfilter(c,tp)
	return c:IsFaceup() and c:IsAbleToRemove()
		and Duel.IsExistingMatchingCard(c92079625.tgfilter,tp,LOCATION_EXTRA,0,1,nil,c:GetAttribute())
end
function c92079625.tgfilter(c,att)
	return c:IsAbleToGrave() and c:IsAttribute(att) and c:IsSetCard(0x9d)
end
function c92079625.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c92079625.cfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c92079625.cfilter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c92079625.cfilter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c92079625.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local att=tc:GetAttribute()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c92079625.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil,att)
		if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0 and g:GetFirst():IsLocation(LOCATION_GRAVE) then
			Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		end
	end
end
function c92079625.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c92079625.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil):GetClassCount(Card.GetOriginalAttribute)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDiscardDeck(tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,ct)
end
function c92079625.tgop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil):GetClassCount(Card.GetOriginalAttribute)
	Duel.DiscardDeck(tp,ct,REASON_EFFECT)
end
