--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 幻煌龙的战涡  (ID: 34302287)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 250
--
-- Effect Text:
-- 场上有「海」存在的场合，这张卡的发动从手卡也能用。
-- ①：自己场上的怪兽只有通常怪兽的场合，以对方场上1张卡为对象才能发动。那张卡破坏。
-- ②：把墓地的这张卡除外，以自己场上1只通常怪兽为对象才能发动。那只怪兽可以装备的自己场上的全部「幻煌龙」装备魔法卡给那只通常怪兽装备。
--[[ __CARD_HEADER_END__ ]]

--幻煌龍の戦渦
function c34302287.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c34302287.condition)
	e1:SetTarget(c34302287.target)
	e1:SetOperation(c34302287.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34302287,1))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c34302287.handcon)
	c:RegisterEffect(e2)
	--equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34302287,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c34302287.eqtg)
	e3:SetOperation(c34302287.eqop)
	c:RegisterEffect(e3)
end
function c34302287.cfilter(c)
	return c:IsFacedown() or not c:IsType(TYPE_NORMAL)
end
function c34302287.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		and not Duel.IsExistingMatchingCard(c34302287.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c34302287.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c34302287.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c34302287.handcon(e)
	return Duel.IsEnvironment(22702055)
end
function c34302287.efilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL)
		and Duel.IsExistingMatchingCard(c34302287.eqfilter,tp,LOCATION_SZONE,0,1,nil,c)
end
function c34302287.eqfilter(c,tc)
	return c:IsFaceup() and c:IsType(TYPE_EQUIP) and c:IsSetCard(0xfa) and c:CheckEquipTarget(tc)
end
function c34302287.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c34302287.efilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c34302287.efilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c34302287.efilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c34302287.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c34302287.eqfilter,tp,LOCATION_SZONE,0,nil,tc)
	local eq=g:GetFirst()
	while eq do
		Duel.Equip(tp,eq,tc,true,true)
		eq=g:GetNext()
	end
	Duel.EquipComplete()
end
