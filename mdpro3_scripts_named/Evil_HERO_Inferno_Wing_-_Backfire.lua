--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 邪心英雄 业火翼魔-地狱逆火  (ID: 59893882)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Fiend
-- Level 6
-- ATK 2100 | DEF 1200
-- Setcode: 24584
--
-- Effect Text:
-- 「元素英雄 羽翼侠」或「元素英雄 爆热女郎」＋「英雄」怪兽
-- 这张卡用「暗黑融合」的效果才能特殊召唤。这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡特殊召唤的场合才能发动。除融合怪兽外的1张「暗黑融合」或者有那个卡名记述的卡从自己的卡组·墓地加入手卡。
-- ②：自己的「英雄」怪兽战斗破坏对方怪兽的场合发动。给与对方2100伤害。
--[[ __CARD_HEADER_END__ ]]

--E-HERO インフェルノ・ウィング－ヘルバック・ファイア
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,94820406,21844576,58932615)
	--material
	aux.AddMaterialCodeList(c,21844576,58932615)
	aux.AddFusionProcCodeFun(c,{21844576,58932615},aux.FilterBoolFunction(Card.IsFusionSetCard,0x08),1,true,true)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.DarkFusionLimit)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id+o)
	e3:SetCondition(s.damcon)
	e3:SetTarget(s.damtg)
	e3:SetOperation(s.damop)
	c:RegisterEffect(e3)
end
s.dark_calling=true
s.material_setcode=0x8
function s.thfilter(c)
	return (c:IsCode(94820406) or aux.IsCodeListed(c,94820406)) and c:IsAbleToHand()
		and not c:IsType(TYPE_FUSION)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.damfilter(c,tp)
	if not c:IsPreviousControler(1-tp) then return false end
	local bc=c:GetReasonCard()
	if not bc then return false end
	if bc:IsRelateToBattle() then
		return bc:IsFaceup() and bc:IsLocation(LOCATION_MZONE) and bc:IsControler(tp) and bc:IsType(TYPE_MONSTER) and bc:IsSetCard(0x8)
	else
		return bc:GetPreviousPosition()&POS_FACEUP>0 and bc:GetPreviousLocation()&LOCATION_MZONE==LOCATION_MZONE and bc:IsPreviousControler(tp)
			and bc:GetPreviousTypeOnField()&TYPE_MONSTER==TYPE_MONSTER and bc:IsPreviousSetCard(0x8)
	end
end
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.damfilter,1,nil,tp)
end
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2100)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2100)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
