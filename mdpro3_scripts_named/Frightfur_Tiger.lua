--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔玩具·剪刀虎  (ID: 464362)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 1900 | DEF 1200
-- Setcode: 173
--
-- Effect Text:
-- 「锋利小鬼·剪刀」＋「毛绒动物」怪兽1只以上
-- ①：「魔玩具·剪刀虎」在自己场上只能有1只表侧表示存在。
-- ②：这张卡融合召唤成功时，以最多有作为这张卡的融合素材的怪兽数量的场上的卡为对象才能发动。那些卡破坏。
-- ③：只要这张卡在怪兽区域存在，自己场上的「魔玩具」怪兽的攻击力上升自己场上的「毛绒动物」怪兽以及「魔玩具」怪兽数量×300。
--[[ __CARD_HEADER_END__ ]]

--デストーイ・シザー・タイガー
function c464362.initial_effect(c)
	c:SetUniqueOnField(1,0,464362)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFunRep(c,30068120,aux.FilterBoolFunction(Card.IsFusionSetCard,0xa9),1,127,true,true)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c464362.descon)
	e2:SetTarget(c464362.destg)
	e2:SetOperation(c464362.desop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xad))
	e3:SetValue(c464362.atkval)
	c:RegisterEffect(e3)
end
function c464362.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c464362.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	local ct=e:GetHandler():GetMaterialCount()
	if chk==0 then return ct>0
		and Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c464362.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(g,REASON_EFFECT)
end
function c464362.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa9,0xad)
end
function c464362.atkval(e,c)
	return Duel.GetMatchingGroupCount(c464362.atkfilter,c:GetControler(),LOCATION_MZONE,0,nil)*300
end
