--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 宝石骑士·红缟  (ID: 43114901)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Pyro
-- Level 4
-- ATK 1800 | DEF 900
-- Setcode: 4167
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当成通常召唤使用的再度召唤，这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡战斗破坏对方怪兽送去墓地时，可以从自己卡组把1张名字带有「宝石骑士」的卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・サニクス
function c43114901.initial_effect(c)
	aux.EnableDualAttribute(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43114901,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c43114901.thcon)
	e1:SetTarget(c43114901.thtg)
	e1:SetOperation(c43114901.thop)
	c:RegisterEffect(e1)
end
function c43114901.thcon(e,tp,eg,ep,ev,re,r,rp)
	if not aux.IsDualState(e) then return false end
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:GetReasonCard()==e:GetHandler()
		and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
end
function c43114901.filter(c)
	return c:IsSetCard(0x1047) and c:IsAbleToHand()
end
function c43114901.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c43114901.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c43114901.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c43114901.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
