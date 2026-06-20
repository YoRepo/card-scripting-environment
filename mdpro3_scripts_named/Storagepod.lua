--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 脚纳母舰 超大腕龙  (ID: 24232799)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Machine
-- Level 6
-- ATK 2500 | DEF 2500
--
-- Effect Text:
-- 「机动要犀 铁犀三角龙」或「盾航战车 电子剑龙」＋机械族·恐龙族怪兽
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要从墓地特殊召唤的怪兽存在，这张卡不会被战斗破坏。
-- ②：这张卡在怪兽区域存在的状态，从手卡有怪兽特殊召唤的场合，以自己以及对方场上的卡各1张为对象才能发动。那些卡破坏。
--[[ __CARD_HEADER_END__ ]]

--脚納母艦ブラキオーバー
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--material
	aux.AddMaterialCodeList(c,12275533,99733359)
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionCode,12275533,99733359),aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE+RACE_DINOSAUR),true)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCondition(s.indescon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCondition(s.descon)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
end
function s.indescon(e)
	return Duel.IsExistingMatchingCard(Card.IsSummonLocation,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,LOCATION_GRAVE)
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSummonLocation,1,nil,LOCATION_HAND)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(Duel.GetTargetsRelateToChain(),REASON_EFFECT)
end
