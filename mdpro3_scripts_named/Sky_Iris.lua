--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 天空的虹彩  (ID: 27813661)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「天空的虹彩」的②的效果1回合只能使用1次。
-- ①：只要这张卡在场地区域存在，自己的灵摆区域的「魔术师」卡、「娱乐伙伴」卡、「异色眼」卡不会成为对方的效果的对象。
-- ②：以这张卡以外的自己场上1张表侧表示的卡为对象才能发动。那张卡破坏，从卡组把1张「异色眼」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--天空の虹彩
function c27813661.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_PZONE,0)
	e2:SetTarget(c27813661.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(27813661,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,27813661)
	e3:SetTarget(c27813661.destg)
	e3:SetOperation(c27813661.desop)
	c:RegisterEffect(e3)
end
function c27813661.tgtg(e,c)
	return c:IsSetCard(0x98,0x9f,0x99)
end
function c27813661.desfilter(c)
	return c:IsFaceup()
end
function c27813661.thfilter(c)
	return c:IsSetCard(0x99) and c:IsAbleToHand()
end
function c27813661.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c27813661.desfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c27813661.desfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c27813661.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c27813661.desfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c27813661.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c27813661.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
