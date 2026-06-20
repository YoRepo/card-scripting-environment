--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 寻你海豚  (ID: 41952656)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 2
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- 场上的这张卡被对方破坏送去墓地时，自己卡组最上面的卡送去墓地。送去墓地的卡是水属性怪兽的场合，从自己卡组抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--イマイルカ
function c41952656.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41952656,0))
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c41952656.drcon)
	e1:SetTarget(c41952656.drtg)
	e1:SetOperation(c41952656.drop)
	c:RegisterEffect(e1)
end
function c41952656.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and not c:IsReason(REASON_RULE) and rp==1-tp and c:IsPreviousControler(tp)
end
function c41952656.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c41952656.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardDeck(tp,1,REASON_EFFECT)==1 then
		local g=Duel.GetOperatedGroup()
		if g:GetFirst():IsAttribute(ATTRIBUTE_WATER) then
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
