--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 森罗的隐蜜 金鱼草  (ID: 47741109)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 1
-- ATK 900 | DEF 400
-- Setcode: 144
--
-- Effect Text:
-- 手卡·场上的这张卡被送去墓地的场合，可以把自己卡组最上面的卡翻开。翻开的卡是植物族怪兽的场合，那只怪兽送去墓地。不是的场合，那张卡回到卡组最下面。此外，卡组的这张卡被卡的效果翻开送去墓地的场合，可以把
-- 自己卡组最上面的卡翻开。翻开的卡是植物族怪兽的场合，那只怪兽送去墓地。不是的场合，那张卡回到卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--森羅の隠蜜 スナッフ
function c47741109.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47741109,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c47741109.condition)
	e1:SetTarget(c47741109.target)
	e1:SetOperation(c47741109.operation)
	c:RegisterEffect(e1)
end
function c47741109.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_HAND+LOCATION_ONFIELD) or (c:IsPreviousLocation(LOCATION_DECK) and	c:IsReason(REASON_REVEAL))
end
function c47741109.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c47741109.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
