--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 伯吉斯异兽·奇虾  (ID: 61307542)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Aqua
-- Rank 2
-- ATK 2400 | DEF 0
-- Setcode: 212
--
-- Effect Text:
-- 2星怪兽×3只以上
-- ①：这张卡不受其他怪兽的效果影响。
-- ②：1回合1次，陷阱卡从自己的魔法与陷阱区域送去墓地的场合才能发动。自己卡组最上面的卡翻开。那张卡是陷阱卡的场合，加入手卡。不是的场合，送去墓地。
-- ③：这张卡有陷阱卡在作为超量素材的场合，1回合1次，把这张卡1个超量素材取除，以场上1张卡为对象才能发动。那张卡破坏。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--バージェストマ・アノマロカリス
function c61307542.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,3,nil,nil,99)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c61307542.efilter)
	c:RegisterEffect(e1)
	--reveal
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(61307542,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1)
	e2:SetCondition(c61307542.condition)
	e2:SetTarget(c61307542.target)
	e2:SetOperation(c61307542.operation)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(61307542,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c61307542.descon)
	e3:SetCost(c61307542.descost)
	e3:SetTarget(c61307542.destg)
	e3:SetOperation(c61307542.desop)
	c:RegisterEffect(e3)
end
function c61307542.efilter(e,re)
	return re:IsActiveType(TYPE_MONSTER) and re:GetOwner()~=e:GetOwner()
end
function c61307542.cfilter(c,tp)
	return c:IsType(TYPE_TRAP) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_SZONE) and c:GetPreviousSequence()<5
end
function c61307542.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c61307542.cfilter,1,nil,tp)
end
function c61307542.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) and tc:IsAbleToHand() end
end
function c61307542.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsType(TYPE_TRAP) and tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	else
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
	end
end
function c61307542.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_TRAP)
end
function c61307542.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c61307542.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c61307542.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
