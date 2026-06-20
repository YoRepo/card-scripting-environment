--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 水面之艾瑞莎  (ID: 22377815)
-- Type: Monster / Effect / Gemini
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 1500 | DEF 500
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当通常召唤使用的再度召唤，这张卡当作效果怪兽使用并得到以下效果。
-- ●这张卡战斗破坏对方怪兽送去墓地时，对方手卡随机丢弃1张。
--[[ __CARD_HEADER_END__ ]]

--水面のアレサ
function c22377815.initial_effect(c)
	aux.EnableDualAttribute(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22377815,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c22377815.con)
	e1:SetTarget(c22377815.tg)
	e1:SetOperation(c22377815.op)
	c:RegisterEffect(e1)
end
function c22377815.con(e,tp,eg,ep,ev,re,r,rp)
	return aux.IsDualState(e) and aux.bdogcon(e,tp,eg,ep,ev,re,r,rp)
end
function c22377815.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c22377815.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
