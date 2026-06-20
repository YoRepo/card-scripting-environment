--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 光道雅典娜 密涅瓦  (ID: 18843291)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Fairy
-- Level 8
-- ATK 2800 | DEF 1800
-- Setcode: 56
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡同调召唤的场合才能发动。把最多有那些作为同调素材的「光道」怪兽数量的「光道」怪兽从卡组送去墓地（相同种族最多1只）。
-- ②：自己场上的「光道」怪兽不能用效果除外。
-- ③：从自己墓地把最多4只「光道」怪兽除外才能发动。把除外数量的卡从自己卡组上面送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ライトロード・アテナ ミネルバ
local s,id,o=GetID()
function s.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.tgcon)
	e1:SetTarget(s.tgtg)
	e1:SetOperation(s.tgop)
	c:RegisterEffect(e1)
	--cannot remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_REMOVE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(s.efilter)
	c:RegisterEffect(e2)
	--remove and tograve
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DECKDES)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,id+o)
	e4:SetCost(s.recost)
	e4:SetTarget(s.retg)
	e4:SetOperation(s.reop)
	c:RegisterEffect(e4)
end
function s.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function s.tgfilter(c)
	return c:IsSetCard(0x38) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():GetMaterial():FilterCount(Card.IsSetCard,nil,0x38)>0 and Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,0,tp,LOCATION_DECK)
end
function s.fselect(g)
	return g:GetClassCount(Card.GetRace)==g:GetCount()
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	local mc=e:GetHandler():GetMaterial():FilterCount(Card.IsSetCard,nil,0x38)
	local g=Duel.GetMatchingGroup(s.tgfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and mc>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		Duel.SendtoGrave(g:SelectSubGroup(tp,s.fselect,false,1,mc),REASON_EFFECT)
	end
end
function s.efilter(e,c,rp,r,re)
	local tp=e:GetHandlerPlayer()
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x38) and c:IsFaceup()
		and r&REASON_EFFECT>0 and r&REASON_REDIRECT==0
end
function s.refilter(c)
	return c:IsSetCard(0x38) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function s.recost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function s.retg(e,tp,eg,ep,ev,re,r,rp,chk)
	local dc=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.IsPlayerCanDiscardDeck(tp,1) and Duel.IsExistingMatchingCard(s.refilter,tp,LOCATION_GRAVE,0,1,nil) and dc>0
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cg=Duel.SelectMatchingCard(tp,s.refilter,tp,LOCATION_GRAVE,0,1,math.min(dc,4),nil)
	e:SetLabel(0,cg:GetCount())
	Duel.Remove(cg,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,cg:GetCount())
end
function s.reop(e,tp,eg,ep,ev,re,r,rp)
	local label,count=e:GetLabel()
	Duel.DiscardDeck(tp,count,REASON_EFFECT)
end
