--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 幻奏的华歌圣 花之普莉玛  (ID: 24672164)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level 7
-- ATK 1900 | DEF 2000
-- Setcode: 155
--
-- Effect Text:
-- 「幻奏的音姬」怪兽＋「幻奏」怪兽1只以上
-- ①：这张卡的攻击力上升作为这张卡的融合素材的怪兽数量×300。
-- ②：这张卡在同1次的战斗阶段中可以作2次攻击。
-- ③：融合召唤的这张卡被送去墓地的场合，以自己墓地1只「幻奏」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--幻奏の華歌聖ブルーム・プリマ
function c24672164.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x109b),aux.FilterBoolFunction(Card.IsFusionSetCard,0x9b),1,127,true)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c24672164.matcheck)
	c:RegisterEffect(e2)
	--Double attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--To hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(24672164,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e4:SetCondition(c24672164.thcon)
	e4:SetTarget(c24672164.thtg)
	e4:SetOperation(c24672164.thop)
	c:RegisterEffect(e4)
end
function c24672164.matcheck(e,c)
	local ct=c:GetMaterialCount()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(ct*300)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
function c24672164.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_FUSION)
end
function c24672164.filter(c)
	return c:IsSetCard(0x9b) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c24672164.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c24672164.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c24672164.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c24672164.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c24672164.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
