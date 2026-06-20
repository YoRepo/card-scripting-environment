--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 抒情歌鸲-护鸟圣域  (ID: 72859417)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 247
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以自己场上2只鸟兽族超量怪兽为对象才能发动。作为对象的怪兽之内1只在另1只怪兽下面重叠作为超量素材（把持有超量素材的怪兽重叠的场合那些超量素材也全部重叠）。
-- ②：持有超量素材3个以上的超量怪兽在自己场上存在的场合才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--LL－バード・サンクチュアリ
function c72859417.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--overlay
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72859417,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,72859417)
	e1:SetTarget(c72859417.target)
	e1:SetOperation(c72859417.activate)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72859417,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,72859418)
	e2:SetCondition(c72859417.drcon)
	e2:SetTarget(c72859417.drtg)
	e2:SetOperation(c72859417.drop)
	c:RegisterEffect(e2)
end
function c72859417.ovfilter(c,e)
	return c:IsFaceup() and c:IsRace(RACE_WINDBEAST) and c:IsType(TYPE_XYZ) and c:IsCanBeEffectTarget(e)
end
function c72859417.gcheck(g)
	return g:IsExists(Card.IsCanOverlay,1,nil)
end
function c72859417.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(c72859417.ovfilter,tp,LOCATION_MZONE,0,nil,e)
	if chk==0 then return g:CheckSubGroup(c72859417.gcheck,2,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg=g:SelectSubGroup(tp,c72859417.gcheck,false,2,2)
	Duel.SetTargetCard(sg)
end
function c72859417.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetsRelateToChain()
	if #g<2 then return end
	if g:IsExists(Card.IsImmuneToEffect,1,nil,e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local c1=g:FilterSelect(tp,Card.IsCanOverlay,1,1,nil):GetFirst()
	if not c1 then return end
	local c2=(g-c1):GetFirst()
	local mg=c1:GetOverlayGroup()
	if mg:GetCount()>0 then Duel.Overlay(c2,mg,false) end
	Duel.Overlay(c2,c1)
end
function c72859417.drfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>=3
end
function c72859417.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c72859417.drfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c72859417.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c72859417.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
