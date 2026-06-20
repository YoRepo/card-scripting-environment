--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 急袭猛禽-死灵秃鹫  (ID: 51814159)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 4
-- ATK 1000 | DEF 1600
-- Setcode: 186
--
-- Effect Text:
-- ①：1回合1次，把自己场上1只「急袭猛禽」怪兽解放，以自己墓地1张「升阶魔法」魔法卡为对象才能发动。那张卡加入手卡。这个效果的发动后，直到回合结束时自己不用「升阶魔法」魔法卡的效果不能把怪兽超量召唤。
--[[ __CARD_HEADER_END__ ]]

--RR－ネクロ・ヴァルチャー
function c51814159.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51814159,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c51814159.thcost)
	e1:SetTarget(c51814159.thtg)
	e1:SetOperation(c51814159.thop)
	c:RegisterEffect(e1)
end
function c51814159.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0xba) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0xba)
	Duel.Release(g,REASON_COST)
end
function c51814159.thfilter(c)
	return c:IsSetCard(0x95) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c51814159.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c51814159.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51814159.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c51814159.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c51814159.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c51814159.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c51814159.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return bit.band(sumtype,SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ and not se:GetHandler():IsSetCard(0x95)
end
