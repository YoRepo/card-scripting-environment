--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 帝王的牲祭  (ID: 72237166)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 2
-- ATK 200 | DEF 100
-- Setcode: 272
--
-- Effect Text:
-- 这张卡为祭品的祭品召唤成功时，这张卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--カイザー・サクリファイス
function c72237166.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72237166,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_RELEASE)
	e1:SetCondition(c72237166.retcon)
	e1:SetTarget(c72237166.rettg)
	e1:SetOperation(c72237166.retop)
	c:RegisterEffect(e1)
end
function c72237166.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_SUMMON)
end
function c72237166.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c72237166.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
