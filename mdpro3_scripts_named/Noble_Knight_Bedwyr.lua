--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 圣骑士 贝德维尔  (ID: 30575681)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1600 | DEF 1500
-- Setcode: 4218
--
-- Effect Text:
-- ①：这张卡召唤·特殊召唤成功时才能发动。从卡组把1张「圣剑」装备魔法卡送去墓地。
-- ②：只在这张卡在场上表侧表示存在才有1次，以场上1张「圣剑」装备魔法卡和1只可以把那张卡装备的怪兽为对象才能发动。那张装备魔法卡转移给作为正确对象的那只怪兽。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--聖騎士ベディヴィエール
function c30575681.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30575681,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c30575681.target)
	e1:SetOperation(c30575681.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--equip change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(30575681,1))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c30575681.eqtg)
	e3:SetOperation(c30575681.eqop)
	c:RegisterEffect(e3)
end
function c30575681.filter(c)
	return c:IsType(TYPE_EQUIP) and c:IsSetCard(0x207a) and c:IsAbleToGrave()
end
function c30575681.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30575681.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c30575681.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c30575681.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c30575681.eqfilter1(c)
	return c:IsSetCard(0x207a) and c:GetEquipTarget()
		and Duel.IsExistingTarget(c30575681.eqfilter2,0,LOCATION_MZONE,LOCATION_MZONE,1,c:GetEquipTarget(),c)
end
function c30575681.eqfilter2(c,ec)
	return c:IsFaceup() and ec:CheckEquipTarget(c)
end
function c30575681.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c30575681.eqfilter1,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g1=Duel.SelectTarget(tp,c30575681.eqfilter1,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	local tc=g1:GetFirst()
	e:SetLabelObject(tc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g2=Duel.SelectTarget(tp,c30575681.eqfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc:GetEquipTarget(),tc)
end
function c30575681.eqop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==ec then tc=g:GetNext() end
	if ec:IsFaceup() and ec:IsRelateToEffect(e) and ec:CheckEquipTarget(tc) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,ec,tc)
	end
end
