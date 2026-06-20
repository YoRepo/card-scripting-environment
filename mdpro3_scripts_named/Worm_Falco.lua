--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 法尔科异虫  (ID: 58760121)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Reptile
-- Level 2
-- ATK 500 | DEF 800
-- Setcode: 62
--
-- Effect Text:
-- 反转：自己场上表侧表示存在的这张卡以外的名字带有「异虫」的爬虫类族怪兽全部变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--ワーム・ファルコ
function c58760121.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetTarget(c58760121.postg)
	e1:SetOperation(c58760121.posop)
	c:RegisterEffect(e1)
end
function c58760121.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE)
end
function c58760121.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c58760121.filter,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c58760121.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c58760121.filter,tp,LOCATION_MZONE,0,aux.ExceptThisCard(e))
	Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE,0,POS_FACEDOWN_DEFENSE,0)
end
