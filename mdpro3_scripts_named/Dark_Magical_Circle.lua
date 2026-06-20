--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 黑魔导阵  (ID: 47222536)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：作为这张卡的发动时的效果处理，从自己卡组上面把3张卡确认。可以从那之中把1只「黑魔术师」或者1张有那个卡名记述的魔法·陷阱卡给对方观看并加入手卡。剩下的卡用喜欢的顺序回到卡组上面。
-- ②：自己场上有「黑魔术师」召唤·特殊召唤的场合，以对方场上1张卡为对象才能发动。那张卡除外。
--[[ __CARD_HEADER_END__ ]]

--黒の魔導陣
function c47222536.initial_effect(c)
	aux.AddCodeList(c,46986414)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,47222536)
	e1:SetTarget(c47222536.target)
	e1:SetOperation(c47222536.activate)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(47222536,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,47222537)
	e2:SetCondition(c47222536.rmcon)
	e2:SetTarget(c47222536.rmtg)
	e2:SetOperation(c47222536.rmop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c47222536.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
end
function c47222536.filter(c)
	return (aux.IsCodeListed(c,46986414) and c:IsType(TYPE_SPELL+TYPE_TRAP) or c:IsCode(46986414)) and c:IsAbleToHand()
end
function c47222536.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(c47222536.filter,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(47222536,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,c47222536.filter,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		Duel.SortDecktop(tp,tp,2)
	else Duel.SortDecktop(tp,tp,3) end
end
function c47222536.cfilter(c,tp)
	return c:IsFaceup() and c:IsCode(46986414) and c:IsControler(tp)
end
function c47222536.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c47222536.cfilter,1,nil,tp)
end
function c47222536.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c47222536.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
