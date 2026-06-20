--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 神数的神意  (ID: 74580251)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 196
--
-- Effect Text:
-- 「神数的神意」在1回合只能发动1张。
-- ①：从卡组把「神数的神意」以外的1张「神数」卡加入手卡。
-- ②：自己场上的「神数」卡被破坏的场合，可以作为代替把墓地的这张卡除外。这个效果在这张卡送去墓地的回合不能使用。
--[[ __CARD_HEADER_END__ ]]

--セフィラの神意
function c74580251.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,74580251+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c74580251.target)
	e1:SetOperation(c74580251.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c74580251.reptg)
	e2:SetValue(c74580251.repval)
	e2:SetOperation(c74580251.repop)
	c:RegisterEffect(e2)
end
function c74580251.filter(c)
	return c:IsSetCard(0xc4) and not c:IsCode(74580251) and c:IsAbleToHand()
end
function c74580251.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74580251.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c74580251.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c74580251.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c74580251.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xc4) and c:IsOnField()
		and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c74580251.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and aux.exccon(e) and eg:IsExists(c74580251.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c74580251.repval(e,c)
	return c74580251.repfilter(c,e:GetHandlerPlayer())
end
function c74580251.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
