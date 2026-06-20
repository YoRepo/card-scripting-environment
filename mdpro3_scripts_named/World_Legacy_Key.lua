--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 通往星遗物的钥匙  (ID: 2930675)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 254
--
-- Effect Text:
-- ①：这张卡的发动时，可以从除外的自己的卡之中以1只「机界骑士」怪兽或者1张「星遗物」卡为对象。那个场合，那张卡加入手卡。
-- ②：只要自己场上有「机界骑士」怪兽存在，和那怪兽相同纵列发动的对方的陷阱卡的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--星遺物へ至る鍵
function c2930675.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c2930675.target)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c2930675.discon)
	e2:SetOperation(c2930675.disop)
	c:RegisterEffect(e2)
end
function c2930675.thfilter(c)
	return ((c:IsSetCard(0x10c) and c:IsType(TYPE_MONSTER)) or c:IsSetCard(0xfe)) and c:IsFaceup() and c:IsAbleToHand()
end
function c2930675.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c2930675.thfilter(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c2930675.thfilter,tp,LOCATION_REMOVED,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(2930675,0)) then
		e:SetCategory(CATEGORY_TOHAND)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c2930675.activate)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectTarget(tp,c2930675.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c2930675.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c2930675.cfilter(c,seq2)
	local seq1=aux.MZoneSequence(c:GetSequence())
	return c:IsFaceup() and c:IsSetCard(0x10c) and seq1==4-seq2
end
function c2930675.discon(e,tp,eg,ep,ev,re,r,rp)
	local loc,seq=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TRIGGERING_SEQUENCE)
	return rp==1-tp and re:IsActiveType(TYPE_TRAP) and loc==LOCATION_SZONE
		and Duel.IsExistingMatchingCard(c2930675.cfilter,tp,LOCATION_MZONE,0,1,nil,seq)
end
function c2930675.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,2930675)
	Duel.NegateEffect(ev)
end
