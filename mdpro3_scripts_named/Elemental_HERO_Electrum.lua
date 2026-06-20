--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 元素英雄 永生侠  (ID: 29343734)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 10
-- ATK 2900 | DEF 2600
-- Setcode: 12296
--
-- Effect Text:
-- 「元素英雄 羽翼侠」＋「元素英雄 爆热女郎」＋「元素英雄 黏土侠」＋「元素英雄 水泡侠」
-- 这只怪兽不能作融合召唤以外的特殊召唤。这张卡的属性也同时当作「风」「水」「炎」「地」使用。这张卡融合召唤成功时，从游戏中除外的全部卡回到持有者的卡组，并洗切卡组。对方场上每存在1只和这张卡相同属性的怪
-- 兽，这张卡攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--E・HERO エリクシーラー
function c29343734.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode4(c,21844576,58932615,84327329,79979666,true,true)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.fuslimit)
	c:RegisterEffect(e2)
	--attribute
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_ADD_ATTRIBUTE)
	e3:SetValue(0xf)
	c:RegisterEffect(e3)
	--return
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(29343734,0))
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c29343734.retcon)
	e4:SetTarget(c29343734.rettg)
	e4:SetOperation(c29343734.retop)
	c:RegisterEffect(e4)
	--atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c29343734.val)
	c:RegisterEffect(e5)
end
c29343734.material_setcode=0x8
function c29343734.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c29343734.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c29343734.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
function c29343734.atkfilter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c29343734.val(e,c)
	return Duel.GetMatchingGroupCount(c29343734.atkfilter,c:GetControler(),0,LOCATION_MZONE,nil,c:GetAttribute())*300
end
