--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 终击龙-电子终结龙  (ID: 30275298)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level 10
-- ATK 4000 | DEF 2800
-- Setcode: 147
--
-- Effect Text:
-- 攻击力2100以上的机械族怪兽×3
-- 这张卡不用融合召唤不能特殊召唤。这个卡名的①的效果1回合只能使用1次。
-- ①：只用光属性怪兽作为素材让这张卡融合召唤的场合，支付4000基本分才能发动。从卡组把1张「限制解除」加入手卡。
-- ②：这张卡向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
-- ③：持有比原本攻击力高的攻击力的这张卡在同1次的战斗阶段中可以作3次攻击。
--[[ __CARD_HEADER_END__ ]]

--終撃竜－サイバー・エンド・ドラゴン
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,23171610)
	--fusion material
	aux.AddFusionProcFunRep(c,s.ffilter,3,true)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.thcon)
	e2:SetCost(s.thcost)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(s.valcheck)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--pierce
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e4)
	--extra att
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_EXTRA_ATTACK)
	e5:SetCondition(s.eacon)
	e5:SetValue(2)
	c:RegisterEffect(e5)
end
function s.ffilter(c,fc)
	return c:IsAttackAbove(2100) and c:IsRace(RACE_MACHINE)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()==1 and e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function s.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,4000) end
	Duel.PayLPCost(tp,4000)
end
function s.thfilter(c)
	return c:IsCode(23171610) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	if g:GetCount()>0 and not g:IsExists(aux.NOT(Card.IsFusionAttribute),1,nil,ATTRIBUTE_LIGHT) then
		flag=1
	end
	e:GetLabelObject():SetLabel(flag)
end
function s.eacon(e)
	local c=e:GetHandler()
	return c:GetAttack()>c:GetBaseAttack()
end
