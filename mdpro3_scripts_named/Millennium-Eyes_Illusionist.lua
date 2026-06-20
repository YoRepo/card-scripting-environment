--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 千年眼幻想师  (ID: 89785779)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 2
-- ATK 0 | DEF 1400
-- Setcode: 430
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把这张卡从手卡丢弃，以对方场上1只效果怪兽为对象才能发动。选自己场上1只「眼纳祭神」融合怪兽或者「纳祭之魔」把作为对象的对方的效果怪兽当作那个效果的装备卡使用来装备。这个效果在对方回合也能发动。
-- ②：场上有「眼纳祭神」融合怪兽或者「纳祭之魔」特殊召唤的场合发动。墓地的这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ミレニアム・アイズ・イリュージョニスト
function c89785779.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89785779,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,89785779)
	e1:SetCost(c89785779.eqcost)
	e1:SetTarget(c89785779.eqtg)
	e1:SetOperation(c89785779.eqop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(89785779,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,89785780)
	e2:SetCondition(c89785779.thcon)
	e2:SetTarget(c89785779.thtg)
	e2:SetOperation(c89785779.thop)
	c:RegisterEffect(e2)
end
function c89785779.eqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c89785779.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsAbleToChangeControler()
end
function c89785779.eqfilter(c)
	local m=_G["c"..c:GetCode()]
	return m and c:IsFaceup() and ((c:IsSetCard(0x1110) and c:IsType(TYPE_FUSION)) or c:IsCode(64631466))
		and not c:IsDisabled() and m.can_equip_monster and m.can_equip_monster(c)
end
function c89785779.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c89785779.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c89785779.filter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c89785779.eqfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c89785779.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c89785779.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc1=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c89785779.eqfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc2=g:GetFirst()
	if not tc2 then return end
	local m=_G["c"..tc2:GetCode()]
	if tc1:IsFaceup() and tc1:IsRelateToEffect(e) and tc1:IsControler(1-tp) then
		m.equip_monster(tc2,tp,tc1)
	end
end
function c89785779.thfilter(c)
	return c:IsFaceup() and ((c:IsSetCard(0x1110) and c:IsType(TYPE_FUSION)) or c:IsCode(64631466))
end
function c89785779.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c89785779.thfilter,1,nil)
end
function c89785779.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c89785779.thop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	end
end
