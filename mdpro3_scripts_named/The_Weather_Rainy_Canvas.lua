--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 雨之天气模样  (ID: 27561302)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 265
--
-- Effect Text:
-- ①：「雨之天气模样」在自己场上只能有1张表侧表示存在。
-- ②：和这张卡相同纵列的自己的主要怪兽区域以及那些两邻的自己的主要怪兽区域存在的「天气」效果怪兽得到以下效果。
-- ●把这张卡除外，以对方场上1张魔法·陷阱卡为对象才能发动。那张卡回到持有者手卡。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--雨の天気模様
function c27561302.initial_effect(c)
	c:SetUniqueOnField(1,0,27561302)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--effect gain
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27561302,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c27561302.thtg)
	e2:SetOperation(c27561302.thop)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c27561302.eftg)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c27561302.eftg(e,c)
	local seq=c:GetSequence()
	return c:IsType(TYPE_EFFECT) and c:IsSetCard(0x109)
		and seq<5 and math.abs(e:GetHandler():GetSequence()-seq)<=1
end
function c27561302.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c27561302.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c27561302.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c27561302.thfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c27561302.thfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c27561302.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
