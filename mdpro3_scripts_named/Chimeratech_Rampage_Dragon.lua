--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 嵌合狂暴龙  (ID: 84058253)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Machine
-- Level 5
-- ATK 2100 | DEF 1600
--
-- Effect Text:
-- 「电子龙」怪兽×2只以上
-- 这张卡的融合召唤不用上记的卡不能进行。
-- ①：这张卡融合召唤时，以最多有作为这张卡的融合素材的怪兽数量的场上的魔法·陷阱卡为对象才能发动。那些卡破坏。
-- ②：1回合1次，自己主要阶段才能发动。从卡组把最多2只机械族·光属性怪兽送去墓地。这个回合，这张卡在同1次的战斗阶段中在通常攻击外加上可以作出最多有这个效果送去墓地的怪兽数量的攻击。
--[[ __CARD_HEADER_END__ ]]

--キメラテック・ランページ・ドラゴン
function c84058253.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1093),2,127,false)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c84058253.descon)
	e2:SetTarget(c84058253.destg)
	e2:SetOperation(c84058253.desop)
	c:RegisterEffect(e2)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c84058253.tgtg)
	e3:SetOperation(c84058253.tgop)
	c:RegisterEffect(e3)
end
c84058253.material_setcode=0x1093
function c84058253.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c84058253.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c84058253.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c84058253.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84058253.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local ct=e:GetHandler():GetMaterialCount()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c84058253.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c84058253.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(g,REASON_EFFECT)
end
function c84058253.tgfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToGrave()
end
function c84058253.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84058253.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c84058253.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c84058253.tgfilter,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoGrave(g,REASON_EFFECT)
	local c=e:GetHandler()
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
	if ct>0 and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(ct)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
